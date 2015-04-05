HyperAdmin.register Article do
  index do
    column :id
    column :title
    column :published_at
  end

  show do
    row :id
    row :title
    row :body, human: "Long and pretty body text"
    row :published_at
  end

  form do
    field :title
    field :body
    field :published_at
  end
end
