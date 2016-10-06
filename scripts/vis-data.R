bleh = read.csv("~/Documents/pronoun-gap-wiki/data/wiki_tfidf.csv", header = TRUE, stringsAsFactors = FALSE)

ggplot(bleh, aes(x = log10((he_counts+1)/(she_counts+1)), y = log10(word_counts), text = first_sentence)) + geom_point(size = .5) -> p 

ggplot(bleh, aes(x = pc0, y = pc1, text = first_sentence, colour = log10((he_counts+1)/(she_counts+1)))) + 
  geom_point(size = .2) -> p


ggplot(bleh, aes(x = log10((he_counts+1)/(she_counts+1)), y = pc1, text = first_sentence, colour = pc2)) + 
  geom_point(size = .2) -> p


bleh$pronoun.ratio = log10((bleh$he_counts+1)/(bleh$she_counts+1))

plot_ly(bleh, x = ~pc0, y = ~pc1, z = ~pc2, color = ~pronoun.ratio)  %>%add_markers(text = ~paste0("", first_sentence))




df.f = subset(bleh, pronoun.ratio < -.1)
df.f$favored.gender = "female"
df.m = subset(bleh, pronoun.ratio > 1)
df.m$favored.gender = "male"

df.gendered = rbind(df.f, df.m)

plot_ly(df.gendered, x = ~pc1, y = ~pc2, z = ~pc3, color = ~pronoun.ratio, size = ~word_counts)  %>%
  add_markers(text = ~paste0("", first_sentence))

ggplot(df.gendered, aes(x = pc2, y = pc3, text = first_sentence, colour = log10((he_counts+1)/(she_counts+1)))) + 
  geom_point(size = .5) -> p


ggplot(bleh, aes(x = log10((he_counts+1)/(she_counts+1)), y = pc2, 
                 text = first_sentence, colour =log10(word_counts))) + 
  geom_point(size = .5) -> p



ggplot(df.gendered, aes(x = pc1, y = pc2, text = first_sentence, colour = favored.gender)) + 
  geom_point(size = .5) ->p


ggplot(df.gendered, aes(x = pronoun_pc1, y = pronoun_pc2, text = first_sentence, colour = favored.gender)) + 
  geom_point(size = .5) ->p

ggplotly(p)

plot_ly(df.gendered, x = ~pronoun_pc0, y = ~pronoun_pc1, z = ~pronoun_pc2, color = ~favored.gender, size = ~word_counts)  %>%
  add_markers(text = ~paste0("", first_sentence))
