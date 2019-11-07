class ParticipationsController < ApplicationController
  before_action :set_participation, only: [:show, :edit, :update, :destroy]

  # GET /participations
  # GET /participations.json
  def index
    @participations = Participation.all
  end

  # GET /participations/1
  # GET /participations/1.json
  def show
  end

  # GET /participations/new
  def new
    @participation = Participation.new
  end

  def subscribe
    if 
      @event.attendees.include? current_user
      flash[:error] = "Vous participez déjà à l'événement"
      redirect_to @event
    else
      @event.attendees << current_user
        flash[:success] = "Vous participez à l'événement"
      redirect_to @event
    end

  end

  # GET /participations/1/edit
  def edit
  end

  # POST /participations
  # POST /participations.json
  def create

    @event = Event.find(params[:event_id ])

    if  @event.attendees.include? current_user
      flash[:error] = "Vous participez déjà à l'événement"
      redirect_to @event
      return
    end

    @amount = @event.price
    
    customer = Stripe::Customer.create({
      email: params[:stripeEmail],
      source: params[:stripeToken],
    })
  
    charge = Stripe::Charge.create({
      customer: customer.id,
      amount: @event.price,
      description: 'Paiement de #{@user.first_name, @user.last_name}',
      currency: 'eur',
    })

    @participation.update(stripe_customer_id: customer.id)


    @event.attendees << current_user
        flash[:success] = "Vous participez à l'événement"
      redirect_to @event
    
    @participation = Participation.create(event_id: @event.id, attendee_id: current_user.id, stripe_customer_id: customer.id)

    puts "§§§§§§§§§§§§§§§§§§#{customer.id}§§§§§§§§§§§§§§§§§§§§§§§§§§§"

    rescue Stripe::CardError => e
      flash[:error] = e.message
      redirect_to new_charge_path

  end

  # PATCH/PUT /participations/1
  # PATCH/PUT /participations/1.json
  def update
    respond_to do |format|

      if @participation.update(participation_params)
        format.html { redirect_to @participation, notice: 'Participation was successfully updated.' }
        format.json { render :show, status: :ok, location: @participation }
      else
        format.html { render :edit }
        format.json { render json: @participation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /participations/1
  # DELETE /participations/1.json
  def destroy
    @participation.destroy
    respond_to do |format|
      format.html { redirect_to participations_url, notice: 'Participation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_participation
      @participation = Participation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def participation_params
      params.require(:participation).permit(:stripe_customer_id, :event_id, :attendee_id)
    end

end
