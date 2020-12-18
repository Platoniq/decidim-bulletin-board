# frozen_string_literal: true

require "decidim/bulletin_board/version"
require "graphlient"
require "wisper"
require "active_model"
require "decidim/bulletin_board/jwk_utils"
require "decidim/bulletin_board/message_identifier"
require "decidim/bulletin_board/client"
require "decidim/bulletin_board/graphql/client"
require "decidim/bulletin_board/voter"
require "decidim/bulletin_board/authority"
require "active_support/configurable"
require "jwt"

module Decidim
  # This module holds all the logic for the Bulletin Board Ruby Client to connect
  # a Decidim instance with a Bulletin Board server
  module BulletinBoard
    include ActiveSupport::Configurable

    # Configure the following variables inside your
    # decidim_bulletin_board.rb initializer

    # The BulletinBoard server (String)
    config_accessor :server

    # The api key generated by the Bulletin Board for the Decidim authority (String)
    config_accessor :api_key

    # The scheme: scheme name and scheme parameters, e.g. quorum for Electionguard
    # Example:
    # {
    #   name: "Dummy",
    #   parameters: {
    #     quorum: 2
    #   }
    # }
    config_accessor :scheme

    # The authority name (String)
    config_accessor :authority_name

    # The number of trustees for an election (Int). Must be higher than the schemes' quorum
    config_accessor :number_of_trustees

    # The identification private key (JSON) for your Decidim instance
    config_accessor :identification_private_key
  end
end
