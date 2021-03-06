class TweetsController < ApplicationController
  before_action :find_tweet, only: [:show, :update, :destroy]

  # 本来であればログインユーザーのチェックやアクションに対する権限があるかどうかのチェックが必要になるが割愛する

  # GET /tweets
  def index
    tweets = Tweet.select_all_with_user
    render response_of_success(tweets)
  end

  # GET /tweets/:id
  def show
    render @tweet.present? ? response_of_success(@tweet) : response_of_not_found(not_found_message)
  end

  # POST /tweets
  def create
    tweet = Tweet.new(params_for_create)
    render tweet.save ? response_of_success(Tweet.find_by_id_with_user(tweet.id)) : response_of_bad_request(tweet.errors.full_messages)
  end

  # PUT /tweets/:id
  def update
    render response_of_not_found(not_found_message) and return if @tweet.blank?
    render @tweet.update(params_for_update) ? response_of_success(@tweet) : response_of_bad_request(@tweet.errors.full_messages)
  end

  # DELETE /tweets/:id
  def destroy
    render response_of_not_found(not_found_message) and return if @tweet.blank?
    render response_of_success(@tweet.destroy)
  end

  private

    def params_for_create
      # 意図しないデータの受け取りを防ぐことができる
      params.require(:tweet).permit(:user_id, :content)
    end

    def params_for_update
      # 意図しないデータの受け取りを防ぐことができる
      params.require(:tweet).permit(:content)
    end

    def find_tweet
      @tweet = Tweet.find_by_id_with_user(params[:id])
    end

    def not_found_message
      '対象のツイートが存在しません。'
    end

    attr_reader :tweet

end
