# config/initializers/cors.rb

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "http://localhost:5173",
    "http://localhost:3000",
    "http://localhost:5174",
    "https://gym-fitness-frontend-production.up.railway.app",
    "https://gym-fitness-frontend-tailwind-production.up.railway.app",
    "https://gym-fitness-api-production.up.railway.app"

    resource "*",
      headers: :any,
      methods: [ :get, :post, :put, :patch, :delete, :options, :head ],
      credentials: true,
      expose: [ "Authorization" ]
  end
end
