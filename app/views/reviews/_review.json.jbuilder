json.extract! review, :id, :name, :text, :like, :created_at, :updated_at
json.url review_url(review, format: :json)
