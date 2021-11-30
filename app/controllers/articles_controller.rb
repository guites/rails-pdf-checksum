class ArticlesController < ApplicationController

  require 'prawn'
  require 'digest'

  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      
      # generates pdf
      file_path = 'articles_pdf/article_' + @article.id.to_s + '.pdf'
      article_pdf = Prawn::Document.new
      article_pdf.text @article.title, style: :bold
      article_pdf.move_down 25
      article_pdf.text @article.body
      article_pdf.move_down 15
      article_pdf.text 'Originally published in ' + @article.created_at.strftime('%d/%m/%Y at %H:%M')
      article_pdf.render_file file_path

      # generates checksums from file and save to database

      md5 = Digest::MD5.file file_path

      sha1 = Digest::SHA1.file file_path

      sha256 = Digest::SHA256.file file_path

      sha512 = Digest::SHA512.file file_path

      @checksum = Checksum.new(md5: md5, sha1: sha1, sha256: sha256, sha512: sha512, article_id: @article.id)
      
      if @checksum.save
        redirect_to @article
      end

    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to root_path
  end

  def download_pdf
    @article = Article.find(params[:id]) 
    file_path = 'articles_pdf/article_' + @article.id.to_s + '.pdf'
    send_file(file_path)
  end

  private
    def article_params
      params.require(:article).permit(:title, :body)
    end

end
