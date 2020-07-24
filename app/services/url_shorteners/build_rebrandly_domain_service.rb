module UrlShorteners
  class BuildRebrandlyDomainService
    def initialize(rebrandly_api: nil)
      @rebrandly_api = rebrandly_api || Rebrandly::Api.new
    end

    def call
      return if selected_domains.empty?

      selected_domains.first
    end

    def selected_domains
      @selected_domains ||= @rebrandly_api.domains.select do |domain|
        domain.full_name == ENV['REBRANDLY_DOMAIN_FULL_NAME'] && domain.active
      end
    end
  end
end
