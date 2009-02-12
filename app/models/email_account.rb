class EmailAccount
	include Validatable
	attr_accessor :username, :password, :server, :port, :email, :ssl, :async
	validates_presence_of 		:username, :password, :server, :email, :port
	validates_format_of				:email, :with => /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
	validates_numericality_of	:port
	
	def initialize(options={})
		@username = options[:username]
		@password = options[:password]
		@server 	=	options[:server]
		@port			= options[:port]
		@email		= options[:email]
		@ssl			=	options.has_key?(:ssl) ? options[:ssl] : false
		@async			=	options.has_key?(:async) ? options[:async] : false
	end
	
end
