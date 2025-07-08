module Api
  module V1
    class JobsController < BaseController
      before_action :set_cached_job, only: [:show]
      before_action :set_job, only: [:update, :destroy]

      # GET /api/v1/jobs
      def index
        if params[:user_id]
          @jobs = AppCache.fetch("jobs_all_user_#{params[:user_id]}", expires_in: 5.minutes) do
            Job.where(user_id: params[:user_id])
          end
        else
          @jobs = AppCache.fetch("jobs_all", expires_in: 5.minutes) do
            Job.all
          end
        end

        render json: @jobs
      end

      # GET /api/v1/jobs/1
      def show
        render json: @job
      end

      # POST /api/v1/jobs
      def create
        @job = Job.new(job_params)

        if @job.save
          AppCache.delete("jobs_all")
          AppCache.delete("jobs_all_user_#{params[:user_id]}")
          render json: @job, status: :created
        else
          render json: { errors: @job.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/jobs/1
      def update
        if @job.update(job_params)
          AppCache.delete("jobs_all")
          AppCache.delete("jobs_all_user_#{@job.user_id}")
          AppCache.delete("job_#{@job.id}")
          render json: @job
        else
          render json: { errors: @job.errors.full_messages }, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/jobs/1
      def destroy
        @job.destroy
        AppCache.delete("jobs_all")
        AppCache.delete("jobs_all_user_#{@job.user_id}")
        AppCache.delete("job_#{@job.id}")
        head :no_content
      end

      private

      def set_cached_job
        @job = AppCache.fetch("job_#{params[:id]}", expires_in: 10.minutes) do
          Job.find(params[:id])
        end
      end

      def set_job
        @job = Job.find(params[:id])
      end

      def job_params
        params.require(:job).permit(:title, :description, :status, :user_id)
      end
    end
  end
end
