class TaskController < ApplicationController
  before_action :raise_error, only: [:show]

  def input; end

  def show
    @max_seg = 0
    str = params[:array]
    arr = str.split(' ').map(&:to_i)
    @segments = get_segments(arr)
    @max_seg = (@segments.max_by { |elem| elem[:length] })[:segment] unless @segments.nil? || @segments.empty?
    @count = @segments.length
  end

  private

  def perfect?(num)
    summ = 0
    ans = false
    (1...num).each do |i|
      summ += i if (num % i).zero?
    end
    ans = true if (summ == num) && num.positive?
    ans
  end

  def get_segments(array)
    result = []
    len = 0
    seg = []
    array.each do |elem|
      if perfect?(elem)
        len += 1
        seg.append(elem)
      else
        result.append({ length: len, segment: seg.join(' ') }) if len.positive?
        len = 0
        seg = []
      end
    end
    result.append({ length: len, segment: seg.join(' ') }) if len.positive?
    result
  end

  def raise_error
    if params[:array].nil? || params[:array].empty?
      flash[:error] = 'Ошибка: параметры не должны быть пустыми.'
      redirect_to root_path
    elsif !params[:array].match(/^( ?-?\d)+$/)
      flash[:error] = 'Ошибка: параметры введены некорректно.'
      redirect_to root_path
    end
  end
end
