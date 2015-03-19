require 'devise/strategies/database_authenticatable'

module Devise
  module Models
    module Restrictable
      def active_for_authentication?
        active? && super
      end

      def active?
        checked_day? && in_work_time? && !in_interval?
      end

      def inactive?
        !active?
      end

      def checked_day?
        checked_days.include? Date.today.wday
      end

      def in_work_time?
        now = DateTime.now.strftime '%H:%M'
        start_time = user_restriction.work_start_time.strftime '%H:%M'
        end_time = user_restriction.end_time_work.strftime '%H:%M'

        start_time <= now && now <= end_time
      end

      def in_interval?
        now = DateTime.now.strftime '%H:%M'
        start_time = user_restriction.start_of_interval.strftime '%H:%M'
        end_time = user_restriction.end_of_interval.strftime '%H:%M'

        start_time <= now && now <= end_time
      end

      def checked_days
        days = []

        %w(sunday monday tuesday wednesday thursday friday saturday).each_with_index do |method, wday|
          if user_restriction.send method.to_sym
            days.push wday
          end
        end

        days
      end

      def inactive_message
        inactive? ? :inactivated : super
      end
    end
  end
end
