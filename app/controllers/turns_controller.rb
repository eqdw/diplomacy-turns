class TurnsController < ApplicationController
  # GET /turns
  # GET /turns.json
  def index
    @inactive_turns = Turn.inactive.where(:user_id => current_user.id).order("round DESC")
    @turn = Turn.where(:user_id => current_user.id).active.first.presence || Turn.new

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @turns }
    end
  end

  # GET /turns/1
  # GET /turns/1.json
  def show
    @turn = Turn.find(params[:id])
    redirect_to turns_path if @turn.active && @turn.user.id != current_user.id


    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @turn }
    end
  end

  # POST /turns
  # POST /turns.json
  def create
    @turn = Turn.new(params[:turn])

    @turn.user = current_user

    respond_to do |format|
      if @turn.save
        format.html { redirect_to turns_path, notice: 'Turn was successfully created.' }
        format.json { render json: @turn, status: :created, location: @turn }
      else
        format.html { render action: "new" }
        format.json { render json: @turn.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /turns/1
  # PUT /turns/1.json
  def update
    @turn = Turn.find(params[:id])

    respond_to do |format|
      if @turn.update_attributes(params[:turn])
        format.html { redirect_to turns_path, notice: 'Turn was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @turn.errors, status: :unprocessable_entity }
      end
    end
  end

end
