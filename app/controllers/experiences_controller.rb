##################################################################
## Controller that manages all REST methods related with User experiences with a lover ##
##################################################################
class ExperiencesController < ApplicationController

  # Token authentication
  before_action :set_user, :authenticate

  before_action :set_lover, only: [:index, :show, :create, :update, :destroy]
  before_action :set_experience, only: [:show, :update, :destroy]

  # Definition of api doc params
  def_param_group :experiences do
    param :experience, Hash do
      param :date, String, required: false
      param :location, String, required: false
      param :moment, [-1,0,1,2], required: false
      param :place, [-1,0,1,2,3,4,5,6,7,8,9], required: false
      param :detail_one, [-1,0,1,2], 'If gender is male, then only can take two values (0 or 1)',required: false
      param :detail_two, [-1,0,1,2], 'If gender is male, then only can take two values (0 or 1)', required: false
      param :detail_three, [0,1,2,-1],'If gender is male, -1 value is assigned because property three doesn\'t exist', required: false
      param :hairdressing, [-1,0,1], '-1 if no value in field', required: false
      param :kiss, [-1,0,1,2,3,4,5,6,7,8,9],'-1 if no value in field', required: false
      param :oral_sex, [-1,0,1,2,3,4,5,6,7,8,9], '-1 if no value in field', required: false
      param :intercourse, [-1,0,1,2,3,4,5,6,7,8,9], '-1 if no value in field', required: false
      param :caresses, [-1,0,1,2,3,4,5,6,7,8,9], '-1 if no value in field', required: false
      param :anal_sex, [-1,0,1,2,3,4,5,6,7,8,9], '-1 if no value in field', required: false
      param :post_intercourse,[-1,0,1,2,3,4,5,6,7,8,9,], '-1 if no value in field', required: false
      param :personal_score, [-1,0,1,2,3,4,5,6,7,8,9], '-1 if no value in field', required: false
      param :visibility, [-1,0,1], required: false
      param :times, Integer, required: false
      param :repeat, [-1,0,1], '-1 if no value in field', required: false
      param :msd_score, Float, required: false
      param :final_score, Integer, required: false
    end
  end

  # Only responds in json format.
  respond_to :json

  api :GET, '/users/:user_id/lovers/:lover_ir/experiences/:experience_id', 'Get lover experiences'
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  example "
  Response:
  {
    'lover_id': 2,
    'experience':
        {
            'experience_id': 1,
            'date': '1111-11-11T00:00:00.000Z',
            'location': 'In my bed',
            'place': 0,
            'detail_one': 1,
            'detail_two': 2,
            'detail_three': 1,
            'hairdressing': 1,
            'kiss': 3,
            'oral_sex': 4,
            'intercourse': 7,
            'caresses': 3,
            'anal_sex': 1,
            'post_intercourse': 9,
            'personal_score': 5,
            'visibility':1,
            'times':3,
            'repeat': 0,
            'msd_score': 0.0,
            'final_score': 4
        }
  }"
  error code:400
  def show
    return render action: 'show'
  end

  api :GET, '/users/:user_id/lovers/:lover_id/experiences', 'Get all experiences of a lover'
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  example "
  Response:
  {
    'user_id': 1,
    'lover_id': 2,
    'experiences': [
        {
            'experience_id': 1,
            'date': '1111-11-11T00:00:00.000Z',
            'location': 'In his bed',
            'place': 0,
            'detail_one': 1,
            'detail_two': 2,
            'detail_three': 1,
            'hairdressing': 1,
            'kiss': 3,
            'oral_sex': 4,
            'intercourse': 7,
            'caresses': 3,
            'anal_sex': 1,
            'post_intercourse': 9,
            'personal_score': 5,
            'visibility':1,
            'times':3,
            'repeat': 0,
            'msd_score': '0.0',
            'final_score': 4
        },
        {
           'experience_id': 2,
            'date': '1111-11-11T00:00:00.000Z',
            'location': 'In my sofa',
            'place': 0,
            'detail_one': 1,
            'detail_two': 2,
            'detail_three': 1,
            'hairdressing': 1,
            'kiss': 3,
            'oral_sex': 4,
            'intercourse': 7,
            'caresses': 3,
            'anal_sex': 1,
            'post_intercourse': 9,
            'personal_score': 5,
            'visibility':1,
            'times':3,
            'repeat': 0,
            'msd_score': '0.0',
            'final_score': 5
        }
      ]
  }"
  error code:400
  def index
    @experiences = @lover.experiences
    return render action: 'index'
  end

  api :POST, '/users/:user_id/lovers/:lover_id/experiences', 'Create an experience'
  param_group :experiences
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  example "
  Request body:
  {
      'date': '11/11/2010',
      'moment':1,
      'location': ' In my sofa',
      'place': 1,
      'detail_one': 1,
      'detail_two': 1,
      'detail_three': 1,
      'hairdressing': 1,
      'kiss': 1,
      'oral_sex': 2,
      'intercourse': 3,
      'caresses': 5,
      'anal_sex': 3,
      'post_intercourse': 5,
      'personal_score': 1,
      'visibility': 1,
      'times': 3,
      'repeat': 1,
      'msd_score': 9.0,
      'final_score': 7
  }

  Response:
  {
    'lover_id': 7,
    'experience': {
        'experience_id': 6,
        'date': '1111-11-11T00:00:00.000Z',
        'moment':1,
        'location': 'In my sofa',
        'place': 1,
        'detail_one': 1,
        'detail_two': 1,
        'detail_three': 1,
        'hairdressing': 1,
        'kiss': 1,
        'oral_sex': 2,
        'intercourse': 3,
        'caresses': 5,
        'anal_sex': 3,
        'post_intercourse': 5,
        'personal_score': 1,
        'visibility':1,
        'times':3,
        'repeat': 1,
        'msd_score': 9.0,
        'final_score': 7
    }
}"
error code:400
  def create
     @experience = @lover.experiences.create(experience_params)
     if !@experience.nil?
      return render action: 'show'
    else
      return render json: {exception: "ExperienceException", message: "Experience cannot be created, #{@experience.errors.full_messages}"}
    end
  end

  api :PUT, '/users/:user_id/lovers/:lover_ir/experiences/:experience_id', 'Updates an experience'
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  param_group :experiences
  example "
  Request body:
  {
    'place':'2'
  }

  Response:
   {
      'experience_id': 2,
      'date': '1111-11-11T00:00:00.000Z',
      'moment': 1,
      'location': 'In my sofa',
      'place': 2,
      'detail_one': 1,
      'detail_two': 1,
      'detail_three': 1,
      'hairdressing': 1,
      'kiss': 3,
      'oral_sex': 4,
      'intercourse': 2,
      'caresses': 5,
      'anal_sex': 6,
      'post_intercourse': 5,
      'personal_score': 5,
      'visibility':1,
      'times':3,
      'repeat': 1,
      'msd_score': 8.0,
      'final_score': 4
  }"
  error code:400
  def update
    if @experience.update(experience_params)
      return render action: 'show', status: :updated
    else
      return render json: @experience.errors.full_messages, status: :unprocessable_entity
    end
  end

  api :DELETE, '/users/:user_id/lovers/:lover_ir/experiences/:experience_id', 'Remove an experience'
  description "
  <b>Headers</b>

  Content-type: application/json

  Authorization: Token token=<remember_token>"
  example "
  {
    'info':'Experience removed successfully'
  }"
  error code: 400
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
        return render json: {exception: "ExperienceException", message: "This user doesn't exist"}, status: 400
      end
    end

    # Defines current lover
    def set_lover
      begin
        @lover = Lover.find(params[:lover_id])
      rescue
        return render json: {exception: "ExperienceException", message: "This lover doesn't exist"}, status: 400
      end
    end

    # Defines current experience
    def set_experience
      begin
        @experience = Experience.find(params[:experience_id])
      rescue
        return render json: {exception: "ExperienceException", message: "This experience doesn't exist"}, status: 400
      end

    end

    # Parameters that are allowed by Experience model.
    def experience_params
      params.require(:experience).permit(:date,:moment,:location,:place,:detail_one,:detail_two,:detail_three,:hairdressing,:kiss,:oral_sex,:intercourse,:caresses,:anal_sex,:post_intercourse,:visibility, :times, :repeat, :personal_score,:next_one,:msd_score,:final_score)
    end

end
