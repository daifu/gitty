Factory.define :valid_preference, :class => Preference do |f|
  f.repositories_directory "/home/git/repositories"
  f.gitosis_directory "/home/git/gitosis"
end

Factory.define :invalid_preference, :class => Preference do |f|
  f.repositories_directory nil
  f.gitosis_directory nil
end