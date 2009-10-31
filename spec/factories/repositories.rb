Factory.define :valid_repo, :class => Repository do |r|
  r.user_id 1
  r.name "gitup"
  r.description "this repo manages gitup code"
  r.homepage "www.gitup.org"
  r.is_public 0
end

Factory.define :invalid_repo, :class => Repository do |r|
end