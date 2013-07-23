##################################################################
## Controller that manages all REST methods related with User experiences with a lover ##
##################################################################
class ExperiencesController < ApplicationController

  # Token authentication
  before_action :set_user, :authenticate

  before_action :set_lover, only: [:index, :show, :create, :update, :destroy]
  before_action :set_experience, only: [:show, :update, :destroy]

  def_param_group :experiences do
    param :experience, Hash do
      param :date, String, required: false
      param :location, String, required: false
      param :moment, [0,1,2], required: false
      param :place, [0...9], required: false
      param :detail_one, [0,1,2], required: false
      param :detail_two, [0,1,2], required: false
      param :detail_three, [0,1,2], required: false
      param :hairdressing, [0,1], required: false
      param :kiss, [0...9], required: false
      param :oral_sex, [0...9], required: false
      param :intercourse, [0...9], required: false
      param :caresses, [0...9], required: false
      param :anal_sex, [0...9], required: false
      param :post_intercourse, [0...9], required: false
      param :personal_score, [0...9], required: false
      param :repeat, [0,1], required: false
      param :msd_score, Float, required: false
      param :bad_lover, Integer, required: false
      param :final_score, Integer, required: false
    end
  end

  # Only responds in json format.
  respond_to :json

  api :GET, '/users/:user_id/lovers/:lover_ir/experiences/:experience_id', 'Get lover experiences'
  description "
  {
    'lover_id': 2,
    'experience':
        {
            'experience_id': 1,
            'date': '1111-11-11T00:00:00.000Z',
            'location': '2',
            'place': null,
            'detail_one': null,
            'detail_two': null,
            'detail_three': null,
            'hairdressing': null,
            'kiss': null,
            'oral_sex': null,
            'intercourse': null,
            'caresses': null,
            'anal_sex': null,
            'post_intercourse': null,
            'personal_score': 5,
            'repeat': null,
            'msd_score': '0.0',
            'bad_lover': null,
            'final_score': 4
        }
  }"
  def show
    return render action: 'show'
  end

  api :GET, '/users/:user_id/lovers/:lover_id/experiences', 'Get all experiences of a lover'
  description "
  {
    'user_id': 1,
    'lover_id': 2,
    'experiences': [
        {
            'experience_id': 1,
            'date': '1111-11-11T00:00:00.000Z',
            'location': '2',
            'place': null,
            'detail_one': null,
            'detail_two': null,
            'detail_three': null,
            'hairdressing': null,
            'kiss': null,
            'oral_sex': null,
            'intercourse': null,
            'caresses': null,
            'anal_sex': null,
            'post_intercourse': null,
            'personal_score': 5,
            'repeat': null,
            'msd_score': '0.0',
            'bad_lover': null,
            'final_score': 4
        },
        {
            'experience_id': 2,
            'date': '1111-11-11T00:00:00.000Z',
            'location': '2',
            'place': null,
            'detail_one': null,
            'detail_two': null,
            'detail_three': null,
            'hairdressing': null,
            'kiss': null,
            'oral_sex': null,
            'intercourse': null,
            'caresses': null,
            'anal_sex': null,
            'post_intercourse': null,
            'personal_score': 5,
            'repeat': null,
            'msd_score': '8.0',
            'bad_lover': null,
            'final_score': 4
        }
      ]
  }"
  def index
    @experiences = @lover.experiences
    return render action: 'index'
  end

  # POST /users/:user_id/lovers/:lover_ir/experiences
  # POST /users/:user_id/lovers/:lover_ir/experiences.json
  api :POST, '/users/:user_id/lovers/:lover_ir/experiences', 'Create an experience'
  def create
      experience = JSON.parse(params[:experience].to_json)
     @experience= @lover.experiences.create(experience)
      return render action: 'show'
  end

  # PUT /users/:user_id/lovers/:lover_ir/experiences/:experience_id.json
  # PUT /users/:user_id/lovers/:lover_ir/experiences/:experience_id
  api :PUT, '/users/:user_id/lovers/:lover_ir/experiences/:experience_id', 'Updates an experience'
  param_group :experiences
  description "
  Response

   {
      'experience_id': 2,
      'date': '1111-11-11T00:00:00.000Z',
      'location': '2',
      'place': null,
      'detail_one': null,
      'detail_two': null,
      'detail_three': null,
      'hairdressing': null,
      'kiss': null,
      'oral_sex': null,
      'intercourse': null,
      'caresses': null,
      'anal_sex': null,
      'post_intercourse': null,
      'personal_score': 5,
      'repeat': null,
      'msd_score': '8.0',
      'bad_lover': null,
      'final_score': 4
  }"
  def update
    if @experience.update(experience_params)
      return render action: 'show', status: :updated
    else
      return render json: @experience.errors.full_messages, status: :unprocessable_entity
    end
  end

  # DELETE /users/:user_id/lovers/:lover_ir/experiences/:experience_id.json
  # DELETE
  api :DELETE, '/users/:user_id/lovers/:lover_ir/experiences/:experience_id', 'Remove an experience'
  description "
  {
    'info':'Experience removed successfully'
  }"
  def destroy
    @experience.destroy
    return render json: {info: "Experience removed successfully"}
  end

  private

    # Defines current user
    def set_user
      begin
        @user = User.find(params[:user_id])
      rescue
        return render json: {exception: "ExperienceException", message: "This user doesn't exist"}, status: 422
      end
    end

    # Defines current lover
    def set_lover
      begin
        @lover = Lover.find(params[:lover_id])
      rescue
        return render json: {exception: "ExperienceException", message: "This lover doesn't exist"}, status: 422
      end
    end

    # Defines current experience
    def set_experience
      begin
        @experience = Experience.find(params[:experience_id])
      rescue
        return render json: {exception: "ExperienceException", message: "This experience doesn't exist"}, status: 422
      end

    end

    # Parameters that are allowed by Experience model.
    def experience_params
      params.require(:experience).permit(:date,:location,:place,:detail_one,:detail_two,:detail_three,:hairdressing,:kiss,:oral_sex,:intercourse,:caresses,:anal_sex,:post_intercourse,:personal_score,:next_one,:msd_score,:bad_lover,:final_score)
    end

end
