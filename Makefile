
run:
	RAILS_ENV=development rails s -b 0.0.0.0 -p 3000 -e development

install:
	@bundle install --jobs=50

update:
	@bundle update --jobs=50

create:
	@rails db:create

migrate:
	@rails db:migrate

seed:
	@rails db:seed

console:
	@rails console

reset:
	@rails db:drop db:create db:migrate db:seed