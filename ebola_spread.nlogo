extensions [ r ]

turtles-own [
  infected?
  contacted?
]

to setup
  clear-all
  set-default-shape turtles "person"
  make-turtles
  infect
  recolor
  reset-ticks
  r:clear
  ;r:interactiveshell     ; this allows user to use the R console
  r:setPlotDevice         ; this allows user to view plots (install JavaGD library in console if you don't have it)
  r:eval "library(ggplot2)"
  r:eval "library(dplyr)"
  r:eval "wd <- '~/Documents/NetLogo6.2.0/NetLogo6.2.0.app'"
  r:eval "setwd(wd)"

end

;; initializes turtles
to make-turtles
  create-turtles num_people [
    set infected? false
    set contacted? false
    setxy random-xcor random-ycor
  ]
end


;; initializes infected turtles
to infect
  ask n-of num_infected turtles [
    set infected? true
    set contacted? true
  ]
end


;; sets infected turtles to red and non-infected to gray
to recolor
  ask turtles [
    ;; if infected?
    set color ifelse-value infected? [ red ] [ gray ]
    ;; set color ifelse-value contacted? [ blue ] [ gray ]
  ]
end


to go
  if all? turtles [ contacted? ] [
    r:put "num_people" num_people
    r:put "num_infected" count turtles with [ infected? ]

    ;; Infected Populations of various studies

    ;; Study Name         Dowell       Baron     Francesconi      Total
    ;; Infected Pop Size    28 -------- 27 --------- 26 ----------- 81
    ;; Total Pop Size       95 -------- 86 --------- 73 ---------- 173

    r:eval "Initial_Pop <- c(95, 86, 73, 173)"
    r:eval "Pop_Infected <- c(28, 27, 26, 81)"

    r:eval "Population_Size <- c(Initial_Pop, num_people)"
    r:eval "Pop_Infected <- c(Pop_Infected, num_infected)"

    r:eval "colors<-c('black','black','black','black','green')"
    r:eval "names(colors) <- Population_Size"

    r:eval "df <- data.frame(Population_Size, Pop_Infected)"
    r:eval "filtered <- filter(df, Population_Size != num_people)"

    r:eval "q <- ggplot(df, aes(x=Population_Size, y=Pop_Infected)) + geom_point(color=factor(colors)) + geom_smooth(method=lm, data=filtered) + scale_color_manual(values=colors) + xlab('Population Size') + ylab('Number of Infected') + theme_bw()"
    r:eval "plot(q)"
    stop
  ]
  spread-infection
  recolor
  move
  tick
end


to spread-infection
  ask turtles with [ infected? ] [
    ;; probability
    ask turtles-here [
      if contacted? != true [set infected? random-float 1 < one-of [.295 .314 .356 .468]]
      set contacted? true
    ]
  ]
end


to move
  ask turtles [
    fd 1
    rt random 30
    lt random 30
  ]
end


;; helps with animation smoothness
to do-layout
  display
end
