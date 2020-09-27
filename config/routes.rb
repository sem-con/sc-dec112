Rails.application.routes.draw do
	mount Rswag::Ui::Engine => '/api-docs'
	mount Rswag::Api::Engine => '/api-docs'
	match '/oauth/revoke'           => 'application#revoke_token',        via: 'post'
	use_doorkeeper do
		skip_controllers :applications
	end
	namespace :api, defaults: { format: :json } do
		scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
#			match 'desc', to: 'semantics#create',         via: 'post'
#			match 'desc', to: 'semantics#show',           via: 'get'
#			match 'desc/info', to: 'semantics#show_info', via: 'get'
#			match 'desc/example', to: 'semantics#show_example', via: 'get'
			match 'active',         to: 'processes#active',       via: 'get'
			match 'init',           to: 'processes#init',         via: 'post'
			match 'meta',           to: 'semantics#create',       via: 'post'
			match 'meta',           to: 'semantics#show',	      via: 'get'
			match 'meta/info',      to: 'semantics#show_info',    via: 'get'
			match 'meta/usage',     to: 'semantics#show_usage',   via: 'get'
			match 'meta/example',   to: 'semantics#show_example', via: 'get'
			match 'data',           to: 'stores#index',           via: 'get'
			match 'data/plain',     to: 'stores#plain',           via: 'get'
			match 'data/full',      to: 'stores#full',            via: 'get'
			match 'data/provision', to: 'stores#provision',       via: 'get'
			match 'data/:id',       to: 'stores#show',            via: 'get'
			match 'data',           to: 'stores#write',           via: 'post'
			match 'info',           to: 'infos#index',            via: 'get'
			match 'log',            to: 'logs#index',             via: 'get'

			match 'receipts',           to: 'receipts#index',         via: 'get'
			match 'receipt/:id',        to: 'receipts#show',          via: 'get'
			match 'receipt/:ttl/:id',   to: 'receipts#show',          via: 'get'
			match 'receipt/:id/revoke', to: 'receipts#revoke',        via: 'delete' 
			match 'rcpt/:id',           to: 'receipts#show',          via: 'get', defaults: { short: "TRUE" }
			match 'rcpt/:ttl/:id',      to: 'receipts#show',          via: 'get', defaults: { short: "TRUE" }
			match 'receipt/:id',        to: 'receipts#create',        via: 'post'
			match 'receipt',            to: 'receipts#create',        via: 'post'

			match 'buy',            to: 'payments#buy',           via: 'post'
			match 'paid',           to: 'payments#paid',          via: 'get'
			match 'payments',       to: 'payments#payments',      via: 'get'

			match 'data/conversation',     to: 'decs#index',         via: 'get'
			match 'data/conversation/:id', to: 'decs#show',          via: 'get', constraints: {id: /[^\/]+/}
			match 'chatbot/welcome',       to: 'chatbots#welcome',   via: 'post'
			match 'chatbot/reply',         to: 'chatbots#reply',     via: 'post'
			match 'chatbot/call_type',     to: 'chatbots#call_type', via: 'post'
		end
	end
	match '/oauth/applications'     => 'application#create_application',  via: 'post'
	match '/oauth/applications/:id' => 'application#destroy_application', via: 'delete'
	match ':not_found' => 'application#missing', :constraints => { :not_found => /.*/ }, via: [:get, :post]
end
