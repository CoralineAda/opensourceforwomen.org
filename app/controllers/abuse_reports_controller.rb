class AbuseReportsController < ApplicationController

  def new
    if params[:offender_id]
      offender = User.find(params[:offender_id])
    else
      offender = User.new
    end
    @abuse_report = AbuseReport.new(reporter: current_user, offender: offender)
  end

  def create
    @abuse_report = AbuseReport.new(abuse_report_params)
    @abuse_report.reporter = current_user
    unless @abuse_report.offender = User.where(username: abuse_report_params[:offender]).first
      flash.now[:error] = 'Sorry! We were unable to find a user with that username. Please try again.'
      render :new
      return
    end

    if @abuse_report.save
      @abuse_report.suspend_account
      AbuseMailer.abuse_email(@abuse_report.id).deliver
      flash.notice = 'Thank you. We will investigate this report within 24 hours.'
      redirect_to dashboard_path(1)
    else
      flash.now[:error] = 'Sorry! We were unable to send your report. Please try again.'
      render :new
    end
  end

  private

  def abuse_report_params
    params.require(:abuse_report).permit(:offender, :description)
  end

end