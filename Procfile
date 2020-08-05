web: bin/rails server -p ${PORT:-5000} -e ${RAILS_ENV:-development}
worker: bundle exec sidekiq -t 25 -q default -q mailers -q active_storage_analysis
release: bin/rails db:migrate
webpacker: ./bin/webpack-dev-server
redis: redis-server
