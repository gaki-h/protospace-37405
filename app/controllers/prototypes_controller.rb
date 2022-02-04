class PrototypesController < ApplicationController
  # before_action :authenticate_user!, only: [:new,:edit,:destroy]
  # before_action :move_to_index, except: [:edit]

  before_action :authenticate_user!, except: [:index, :show]
  # before_action :move_to_index, except: [:index, :show]
  # before_action :move_to_index, except: [:index,:edit]
  before_action :set_prototype, except: [:index, :new, :create]
  before_action :contributor_confimation, only: [:edit, :update, :destroy]

  def index
    # @prototypes = Prototype.all
    @prototype = Prototype.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    # @prototype = Prototype.find(params[:id])
   if @prototype.destroy
    redirect_to root_path
   else
    redirect_to root_path
   end
  end

  def edit
    # @prototype = Prototype.find(params[:id])
    # if @prototype.user_id == current_user.id
    #   render :edit
    # else
    #   redirect_to root_path 
    # end
    # unless current_user == @prototype.user
    #   redirect_to root_path
    # end
    # unless user_signed_in?
    #   redirect_to root_path
    # end
  end

  def update
    # @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path(@prototype)
    else
      render :edit
    end
  end

  def show
    # @prototype = Prototype.find(params[:id])
    @comment = Comment.new
    # @comments = @prototype.comments.includes(:user)
    @comments = @prototype.comments

  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept,:image).merge(user_id: current_user.id)
  end

  # def move_to_index
  #   # @prototype = Prototype.find(params[:id])
  #   unless user_signed_in? 
  #     redirect_to root_path
  #   end
  def set_prototype
    @prototype = Prototype.find(params[:id])
  end

  def contributor_confimation
    redirect_to root_path unless current_user == @prototype.user
  end 
end