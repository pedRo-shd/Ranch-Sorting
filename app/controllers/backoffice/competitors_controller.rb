class Backoffice::CompetitorsController < BackofficeController
  before_action :set_competitor, only: [:edit, :update, :destroy, :show]
  before_action :set_competition_by_competitor, only: [:new]

  def index
    @competitors = Competitor.where(competition_id: params[:competition_id])
  end

  def new
    @competitor = Competitor.new
  end

  def create
    @competitor = Competitor.new(params_competitor)
    @competitor.competition_id = params[:competition_id]
    if @competitor.save
      redirect_to backoffice_competitors_path(competition_id: params[:competition_id]), notice: "O (#{@competitor.name}) foi cadastrada com sucesso!"
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @competitor.update(params_competitor)
      redirect_to backoffice_competitors_path, notice: "A competição (#{@competitor.name}) foi cadastrada com sucesso!"
    else
      render :edit
    end
  end

  def destroy
    if @competitor.destroy
      redirect_to backoffice_competitors_path, notice: "A (#{@competitor.name}) foi deletado com sucesso!"
    else
      render :index
    end
  end

  private

  def set_competitor
     @competitor = Competitor.find(params[:id])
  end

  def set_competition_by_competitor
    raise NotHaveCompetition unless params[:competition_id]
  end


  def params_competitor
    params.require(:competitor).permit(:name, :number_races, :competition_id)
  end
end
