class Admin::AbuseReportsController < Admin::AdminController

  def index
    @abuse_reports = AbuseReport.all.order("created_at DESC")
  end

  def show
    @report = AbuseReport.find(params[:id])
  end

  def update
    @report = AbuseReport.find(params[:id])
    if @report.update_attributes(abuse_report_params)
      flash[:info] = 'The abuse report has been updated.'
      redirect_to admin_abuse_reports_path
    else
      flash.now[:error] = @report.errors.full_messages
      render 'show'
    end
  end

  private

  def abuse_report_params
    params.require(:abuse_report).permit(
      :is_resolved
    )
  end

end