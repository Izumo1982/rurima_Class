
def get_slice(source, st_no, st_plus, st_wd, en_wd)
	st = source.index(/#{st_wd}/, st_no)
  return nil, 0 if st == nil
	st += st_plus
  en = source.index(/#{en_wd}/, st + 1)
  return source.slice(st..en - 1), en
end

def rurima_get
require 'open-uri'

	dir = ['TracePoint','Complex','Rational','FiberError','Fiber','ClosedQueueError','ThreadError','ThreadGroup','Thread','RubyVM','StopIteration','Enumerator','Binding','UnboundMethod','Method','SystemStackError','LocalJumpError','Proc','Random','Time','Dir','File','ARGF','IO','EOFError','IOError','Range','MatchData','Regexp','RegexpError','Struct','Hash','Array','Float','Integer','Numeric','FloatDomainError','ZeroDivisionError','UncaughtThrowError','SystemCallError','NoMatchingPatternError','EncodingError','NoMemoryError','SecurityError','FrozenError','RuntimeError','NoMethodError','NameError','NotImplementedError','LoadError','SyntaxError','ScriptError','RangeError','KeyError','IndexError','ArgumentError','TypeError','StandardError','Interrupt','SignalException','fatal','SystemExit','Exception','Symbol','String','Encoding','FalseClass','TrueClass','Data','NilClass','Class','Module','Object','BasicObject','Monitor']
  all_keisyo = []
	dir.each do  |fil|
		mod_cla = []
    p fil
    source = (URI.open("https://docs.ruby-lang.org/ja/latest/class/#{fil}.html")).read
		dat = get_slice(source, 0,9,"クラスの継承リスト:","</nav>")
		mod_cla[0] = get_slice(source, 0, 4, %r*<h1>*, %r*</h1>*)[0]
		dat = dat[0].gsub(/\n/,'').gsub(/\r/,'').gsub(/\t/,'').gsub(/\"/,'').gsub(/,/,'').gsub(/ /,'').scan(/>\w\w*</)
		mod_cla[1] = dat.map!{|d| d.gsub(/>/,'').gsub(/</,'')}
		all_keisyo.push(mod_cla)
	end

	fi = File.open("keisyo.csv", "w")
  
  all_keisyo.each {|a|fi.puts a.flatten.join',' } 

  fi.close

end

rurima_get
