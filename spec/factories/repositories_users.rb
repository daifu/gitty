Factory.define :valid_repo, :class => RepositoriesUsers do |r|
  r.repository_id 1
  r.sequence(:user_id) { |u| u }
  r.is_owner 1
end