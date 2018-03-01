import requests, json, sys

class GitHubFetcher():

  def __init__(self, *argv):
    self.endpoint = 'https://api.github.com/repos/vinay-shipt/de-take-home'
    self.contributor_url = self.request(self.endpoint)['contributors_url']
    self.contributors = self.request(self.contributor_url)
    self.get_contributors(self.contributors)

  def request(self, endpoint):
    response = requests.get(self.endpoint)
    text_object = json.loads(response.text)
    return text_object

  def get_contributors(self, contributors):
    if type(contributors) is dict:
      print(contributors['login'])
    else:
      for contributor in contributors:
        print(contributor['login'])

if __name__ == '__main__':
  GitHubFetcher()