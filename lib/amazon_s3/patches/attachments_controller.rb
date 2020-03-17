AttachmentsController.class_eval do

  before_action :find_thumbnail_attachment, :only => [:thumbnail]
  skip_before_action :file_readable

  def show
    if @attachment.container.respond_to?(:attachments)
      @attachments = @attachment.container.attachments.to_a
      if index = @attachments.index(@attachment)
        @paginator = Redmine::Pagination::Paginator.new(
          @attachments.size, 1, index+1
        )
      end
    end
    if @attachment.is_diff?
      @diff = AmazonS3::Connection.get(@attachment.disk_filename_s3)
      @diff_type = params[:type] || User.current.pref[:diff_type] || 'inline'
      @diff_type = 'inline' unless %w(inline sbs).include?(@diff_type)
      # Save diff type as user preference
      if User.current.logged? && @diff_type != User.current.pref[:diff_type]
        User.current.pref[:diff_type] = @diff_type
        User.current.preference.save
      end
      render :action => 'diff'
    elsif @attachment.is_text? && @attachment.filesize <= Setting.file_max_size_displayed.to_i.kilobyte
      @content = AmazonS3::Connection.get(@attachment.disk_filename_s3)
      render :action => 'file'
    else
      download
    end
  end

  def download
    if @attachment.container.is_a?(Version) || @attachment.container.is_a?(Project)
      @attachment.increment_download
    end
    redirect_to(AmazonS3::Connection.object_url(@attachment.disk_filename_s3))
  end

  private

  def find_editable_attachments
    if @attachments
      @attachments.each { |a| a.increment_download }
    end
  end

  def find_thumbnail_attachment
    update_thumb = 'true' == params[:update_thumb]
    url          = @attachment.thumbnail_s3(update_thumb: update_thumb)
    return render json: {src: url} if update_thumb
    return if url.nil?
    redirect_to(url)
  end

end

