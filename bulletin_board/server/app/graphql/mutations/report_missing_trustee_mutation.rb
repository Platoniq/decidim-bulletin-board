# frozen_string_literal: true

module Mutations
  class ReportMissingTrusteeMutation < BaseMutation
    argument :message_id, String, required: true
    argument :signed_data, String, required: true

    field :pending_message, Types::PendingMessageType, null: true
    field :error, String, null: true

    def resolve(message_id:, signed_data:)
      authority = find_authority(message_id)

      return { error: "Authority not found" } unless authority

      result = { error: "There was an error reporting the missing trustee." }

      EnqueueMessage.call(authority, message_id, signed_data, ReportMissingTrusteeJob) do
        on(:ok) do |pending_message|
          result = { pending_message: pending_message }
        end
      end

      result
    end
  end
end
