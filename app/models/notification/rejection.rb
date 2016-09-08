class Notification::Rejection < Notification
  REASONS = [
    :unsuitable_name,
    :too_long,
    :fraudulent].freeze
end
