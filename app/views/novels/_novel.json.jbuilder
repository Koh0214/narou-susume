json.extract! novel, :id, :title, :description, :url, :like, :osusume_id, :created_at, :updated_at
json.url novel_url(novel, format: :json)
