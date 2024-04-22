# Use the official Ruby image as base
FROM ruby:2.7.4

# Install essential Linux packages
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

# Set an environment variable for the Rails app directory
ENV RAILS_ROOT /app
RUN mkdir $RAILS_ROOT

# Set working directory
WORKDIR $RAILS_ROOT

# Copy Gemfile and Gemfile.lock
COPY Gemfile Gemfile.lock ./

# Install gems
RUN gem install bundler
RUN bundle install

# Copy the Rails application
COPY . .

# Expose port 3000 to the Docker host, so we can access the Rails app
EXPOSE 3000

# Start the Rails server
CMD ["rails", "server", "-b", "0.0.0.0"]
