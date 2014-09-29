HyperAdmin.register Person do
  index do
    column :first_name
    column :last_name
  end

  show do
    row :id
    row :first_name
    row :last_name
    row :birthday, type: :date
    row :url, type: :url
  end

  form do
    field :first_name
    field :last_name
    field :birthday
    field :email, type: :email
    field :url, type: :url

  end
end
