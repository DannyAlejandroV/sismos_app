# Define el controlador de la API
class Api::FeaturesController < ApplicationController
    def index
      features = Feature.all
      features = features.where(mag_type: params[:filters][:mag_type]) if params[:filters] && params[:filters][:mag_type]
      features = features.page(params[:page]).per(params[:per_page] || 10)
  
      render json: features, each_serializer: FeatureSerializer, meta: pagination_meta(features)
    end
  
    def create_comment
      feature = Feature.find(params[:feature_id])
      comment = feature.comments.build(comment_params)
  
      if comment.save
        render json: comment, status: :created
      else
        render json: { error: 'No se pudo guardar el comentario' }, status: :unprocessable_entity
      end
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:body)
    end
  
    def pagination_meta(collection)
      {
        current_page: collection.current_page,
        total: collection.total_count,
        per_page: collection.limit_value
      }
    end
  end
  