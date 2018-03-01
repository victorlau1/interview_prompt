import requests, json, sys

class GitHubFetcher():

  def __init__(self, *argv):
    self.endpoint = 'https://api.github.com/repos/vinay-shipt/de-take-home'
    self.contributor_url = self.githubfetch(self.endpoint)['contributors_url']
    self.contributors = self.githubfetch(self.contributor_url)
    self.get_contributors(self.contributors)

  def githubfetch(self, endpoint):
    response = requests.get(endpoint)
    text_object = json.loads(response.text)
    return text_object

  def get_contributors(self, contributors):
    for contributor in contributors:
      #Could Write to File Here or save to DB?
      print(contributor['login'])

if __name__ == '__main__':
  GitHubFetcher()