class Calculator
  attr_accessor :num, :viewer

  def initialize(shoes)
    @num = 0
    @stack = [0]
    @shoes = shoes
    @viewer = @shoes.title(0)
  end
  
  def create_button(text)
    @shoes.button text, width: '25%' do
      operation(text)
    end
  end

  def calc
    @stack.pop if %w(+ - * /).include?(@stack.last)
    @num = eval(@stack.join(' '))
    @stack = [@num]
    update
  end

  def add_operator(operator)
    unless %w(+ - * /).include?(@stack.last)
      @num = [eval(@stack.join(' '))]
      @stack << operator
      update
    end
  end

  def add(num)
    @stack << 0 if %w(+ - * /).include?(@stack.last)
    @stack[-1] = ( @stack.last.to_s + num ).to_i
    temp_update
  end

  def update
    @viewer.replace(@num)
  end

  def clear
    @num = 0
    @stack = [0]
    update
  end

  def temp_update
    @viewer.replace(@stack.last)
  end

  def operation(text)
    case text
    when *%w(+ - * /)
      add_operator(text)
    when *%w(0 1 2 3 4 5 6 7 8 9)
      add(text)
    when 'C'
      clear
    when '='
      calc
    end
  end
end

Shoes.app( title: 'Calculator', width: 400, height: 300 ) do
  @calculator = Calculator.new(self)
  @calculator.viewer
  flow do
    @calculator.create_button('7')
    @calculator.create_button('8')
    @calculator.create_button('9')
    @calculator.create_button('/')
  end
  flow do
    @calculator.create_button('4')
    @calculator.create_button('5')
    @calculator.create_button('6')
    @calculator.create_button('*')
  end
  flow do
    @calculator.create_button('1')
    @calculator.create_button('2')
    @calculator.create_button('3')
    @calculator.create_button('-')
  end
  flow do
    @calculator.create_button('0')
    @calculator.create_button('C')
    @calculator.create_button('=')
    @calculator.create_button('+')
  end
  @calculator.viewer.style( height: 40, align: 'right', margin: 30 )
end
