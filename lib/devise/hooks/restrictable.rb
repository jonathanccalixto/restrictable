Warden::Manager.after_set_user do |record, warden, options|
  if record && record.respond_to?(:active_for_authentication?) && record.active_for_authentication?
    scope     = options[:scope]
    request   = warden.request
    session   = warden.session(scope)

    if record.respond_to?(:connected?) && record.connected?(request)
      warden.logout(scope)
      throw :warden, scope: scope, message: record.connected_message
    end

    if record.respond_to?(:disconnected?) && record.disconnected?(request)
      session["connected"] = "true"
      record.set_to_connected!(request)
    end
  end
end


Warden::Manager.before_logout do |record, warden, options|
  scope     = options[:scope] || warden.config.default_scope
  session   = warden.request.session["warden.user.#{scope}.session"] || {}

  if record && session["connected"].present?
    session["connected"] = 'false'
    record.set_to_disconnected!
  end
end