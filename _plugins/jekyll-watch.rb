module Jekyll
  class WatcherLogger < Jekyll::Plugin
    def self.post_read(site)
      Jekyll.logger.info "👀 Jekyll Watch:", "Đã phát hiện thay đổi file! Rebuilding..."
    end
  end

  Hooks.register :site, :post_read do |site|
    WatcherLogger.post_read(site)
  end
end

