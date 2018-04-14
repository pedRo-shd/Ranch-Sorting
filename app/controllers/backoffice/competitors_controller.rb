class Backoffice::CompetitorsController < BackofficeController
  before_action :set_competitor, only: %i[edit update destroy]
  before_action :set_competition_by_competitor, only: %i[new]

  def index
    @competitors = Competitor.where(competition_id: params[:competition_id])
  end

  def new
    @competitor = Competitor.new
  end

  def create
    puts params
    @competitor = Competitor.new(params_competitor)
    if @competitor.save
      redirect_to backoffice_competition_path(@competitor.competition_id),
       notice: "O competidor (#{@competitor.name}) foi cadastrado com sucesso!"
    else
      render :new
    end
  end

  def edit
    @competition = @competitor.competition
  end

  def update
    if @competitor.update(params_competitor)
      redirect_to backoffice_competition_path(@competitor.competition_id),
        notice: "O competidor (#{@competitor.name}) foi atualizado com sucesso!"
    else
      render :edit
    end
  end

  def destroy
    if @competitor.destroy
      redirect_to backoffice_competitors_path, notice: "O (#{@competitor.name}) foi excluído com sucesso!"
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
    @competition = Competition.find(params[:competition_id])
  end


  def params_competitor
    params.require(:competitor).permit(:name, :number_races, :paid, :price, :competition_id)
  end
end
