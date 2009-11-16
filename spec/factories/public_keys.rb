Factory.define :valid_public_key, :class => PublicKey do |p|
  p.user { |u| u.association(:valid_user) }
  p.title "Insoshi's Default Key :-)"
  p.key "MIGJAoGBAO1iQw8IfH0v/WxlkWDbt30kkXBqmPhhpZdCHNCpRiynZeeaZiTh+6C1I0pThspCV/59ScKFmwD/++fVW4J2dvItAMYwZg87xFAoik5YB0z1IgjT40PQGtSvW76wly7T0BdR31yqWxrWceYyqMj31+2/vUEmvwLjN6Dklwo74t8lAgMBAAE= insoshi@insoshi.com"
end

Factory.define :invalid_public_key, :class => PublicKey do |p|
end