require 'devise/strategies/database_authenticatable'
require 'devise/hooks/restrictable'

module Devise
  module Models
    module Restrictable
      WEEKDAYS = [:sunday, :monday, :tuesday, :wednesday, :thursday, :friday, :saturday]

      def active_for_authentication?
        active? && super
      end

      def active?
        checked_day? && in_work_time? && !in_interval?
      end

      def inactive?
        !active?
      end

      def inactive_message
        inactive? ? :inactivated : super
      end

      def connected?(request)
        return false unless !!connected_at && !!connected_ip && respond_to?(:timeout_in)

        timeout_in.ago <= connected_at && connected_ip != request.remote_ip
      end

      def disconnected?(*args)
        !connected?(*args)
      end

      def set_to_connected!(request)
        update_column :connected_at, Time.now.utc
        update_column :connected_ip, request.remote_ip
        update_column :updated_at, Time.now.utc
      end

      def set_to_disconnected!
        update_column :connected_at, nil
        update_column :connected_ip, nil
        update_column :updated_at, Time.now.utc
      end

      def connected_message
        :already_connected
      end

      protected

      def checked_days
        days = []

        WEEKDAYS.each_with_index do |method, wday|
          days << wday if send(:"#{method}?")
        end

        days
      end

      def checked_day?
        return true if every_day?

        checked_days.include? Date.today.wday
      end

      def in_work_time?
        return false unless work_start_time && end_time_work

        now        = I18n.l Time.now.utc, format: time_format
        start_time = I18n.l self.work_start_time, format: time_format
        end_time   = I18n.l self.end_time_work, format: time_format

        start_time <= now && now <= end_time
      end

      def in_interval?
        return false unless start_of_interval && end_of_interval

        now        = I18n.l Time.now.utc, format: time_format
        start_time = I18n.l self.start_of_interval, format: time_format
        end_time   = I18n.l self.end_of_interval, format: time_format

        start_time <= now && now <= end_time
      end

      private

      def time_format
        I18n.t "time.formats.time"
      end
    end
  end
end