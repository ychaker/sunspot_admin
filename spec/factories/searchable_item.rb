Factory.define :user_name, :class => SearchableItem do |u|
  u.searchable_model        'User'
  u.searchable_field        'name'
  u.searchable_field_type   'string'
  u.searchable_status       SearchableItem::NOTPREPARED
end

Factory.define :user_initials, :class => SearchableItem do |u|
  u.searchable_model        'User'
  u.searchable_field        'initials'
  u.searchable_field_type   'string'
  u.searchable_status       SearchableItem::NOTPREPARED
end

Factory.define :company_name, :class => SearchableItem do |u|
  u.searchable_model        'Company'
  u.searchable_field        'name'
  u.searchable_field_type   'string'
  u.searchable_status       SearchableItem::NOTPREPARED
end

Factory.define :dummy_name, :class => SearchableItem do |u|
  u.searchable_model        'Dummy'
  u.searchable_field        'name'
  u.searchable_field_type   'string'
  u.searchable_status       SearchableItem::NOTPREPARED
end

Factory.define :dummy_description, :class => SearchableItem do |u|
  u.searchable_model        'Dummy'
  u.searchable_field        'description'
  u.searchable_field_type   'text'
  u.searchable_status       SearchableItem::NOTPREPARED
end

Factory.define :dummy_age, :class => SearchableItem do |u|
  u.searchable_model        'Dummy'
  u.searchable_field        'age'
  u.searchable_field_type   'integer'
  u.searchable_status       SearchableItem::NOTPREPARED
end