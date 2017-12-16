class Backoffice::CompetitionsController < BackofficeController
  before_action :set_competition, only: [:edit, :update, :destroy, :show]

  def index
    @competitions = Competition.all
  end

  def new
    @competition = Competition.new
  end

  def create
    @competition = Competition.new(params_competition)
    if @competition.save
      redirect_to backoffice_competition_path(@competition), notice: "A competição (#{@competition.title}) foi cadastrada com sucesso!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @competition.update(params_competition)
      redirect_to backoffice_competitions_path, notice: "A competição (#{@competition.title}) foi cadastrada com sucesso!"
    else
      render :edit
    end
  end

  def show
    #
  end

  def destroy
    raise HaveCompetitors if @competition.competitors.present?
    if @competition.destroy
      redirect_to backoffice_competitions_path, notice: "A competição (#{@competition.title}) foi deletado com sucesso!"
    else
      render :index
    end
  end

  private

  def set_competition
     @competition = Competition.find(params[:id])
  end

  def params_competition
    params.require(:competition).permit(:title, :price, :city, :state)
  end
end
