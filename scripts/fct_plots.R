bar1 <- function(current = NULL, potential = NULL, goal = NULL, label = NULL) {
  # create data
  d <- tibble(
    category = c("Current", "Potential", "Gap"),
    value0 = c(current, potential, goal),
    group = "group"
  )
  # convert values to relative differences
  d$value <- c(
    d$value0[1],
    d$value0[2],
    d$value0[3] - d$value0[1] - d$value0[2]
  )

  # convert to factor
  d <- d %>%
    mutate(category = factor(category, levels = c("Gap", "Potential", "Current")))

  # remove zeros if needed
  d <- d %>% filter(value > 0)

  # plot data
  p <- ggplot(d, aes(x = group, y = value)) +
    geom_col(aes(fill = category), width = 0.8) +
    coord_flip() +
    scale_fill_manual(
      values = alpha(
        c("Current" = "#1b9e77", "Potential" = "#d95f02", "Gap" = "#636363"),
        c(1, 1, 0.5)
      )
    ) +
    ylab(label) +
    xlab("") +
    labs(fill = "") +
    theme(legend.position = "none") +
    theme(
      axis.text.y = element_blank(),
      axis.ticks.y = element_blank()
    ) +
    geom_hline(yintercept = d$value0[3], colour = "#636363", size = 1.2)

  ggplotly(p) %>% config(displayModeBar = F)

}


plot_consvar <- function(consvar, user_pmp, unit) {

    renderPlotly({
    bar1(current = reg_goals %>% filter(Regions == user_pmp$Regions) %>%
           filter(Category == "current") %>% pull(consvar), 
         potential = user_pmp$Grassland, 
         goal = reg_goals %>% filter(Regions == user_pmp$Regions) %>%
           filter(Category == "goal") %>% pull(consvar),
         label = paste0(consvar, " (",unit,")")
    )
  })  
} 

