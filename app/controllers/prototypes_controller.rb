class PrototypesController < ApplicationController
  before_action :authenticate_user!
  before_action :move_to_index, except: [:index]

  def index
    @prototypes=Prototype.all
    # [{"id" => 2,"title" => " ","concept" => " ","catch_copy" => " ","image" => " "},
    #   {"id" => 3,"title" => " ","concept" => " ","catch_copy" => " ","image" => " "}]
  end

  def new
    @prototype=Prototype.new
    # "prototype" => {"title" => " ","concept" => " ","catch_copy" => " ","image" => " "}
    #Prototypeモデルの情報を取得して変数に代入
  end
  
  def create
      @prototype=Prototype.new(prototype_params)
      # "prototype" => {"title" => "投稿のタイトル","concept" => "楽しい","catch_copy" => "感動をプレゼント","image" => " "}

      if @prototype.save
       #createはcreateメソッドであり、データを保存するメソッド
       redirect_to '/'
    else
       render :new, status: :unprocessable_entity
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
    # params = {.....,"id" => 2, .....}
    # params[:id] == 2
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    prototype = Prototype.find(params[:id])
    if prototype.update(prototype_params)
       redirect_to prototype_path(prototype.id)
    else
       render :edit, status: :unprocessable_entity
    end
  end

def destroy
  prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
end

  private
  def prototype_params
      params.require(:prototype).permit(:title, :catch_copy, :concept,:image).merge(user_id: current_user.id)
  end
  # params = {....,
  #   "prototype" => {"title" => "投稿のタイトル", "concept" => "楽しい", "catch_copy" => "感動をプレゼント","image" => " "},
  #          .....}
  # params[:prototype]

  def move_to_index
    @prototype = Prototype.find(params[:id])
    unless user_signed_in? && current_user.id == @prototype.user_id
      redirect_to action: :index
    end
  end
end