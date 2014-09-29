HyperAdmin.register Article do
  show do
    row :id
    row :title
    row :body, human: "Long and pretty body text"
    row :published_at
  end

  form do
    field :title
    field :body, type: :string
  end
end
