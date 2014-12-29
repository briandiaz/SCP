class OmniAuthMiddleware
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, body = @app.call(env)
    request = Rack::Request.new(env)
    if request.xhr? and status == 302 and request.path_info =~ /\/auth\/\w+\z/ and body.class == Rack::BodyProxy
      location = headers["Location"]
      body = ActionDispatch::Response.new
      headers = {'Content-Type'=>'text/javascript; charset=utf-8'}
      body.body = ["window.location.href='#{location}'"]
      body.headers = headers
      status = 200
    end
    [status,headers,body]
  end
end