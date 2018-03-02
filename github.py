import requests, json, sys, os

class GitHubFetcher():

  def __init__(self, *argv):
    self.endpoint = 'https://api.github.com/repos/vinay-shipt/de-take-home'
    self.token = os.environ['TOKEN']

    #Actions to Create the call
    self.contributor_url = self.githubfetch(self.endpoint)['contributors_url']
    self.contributors = self.githubfetch(self.contributor_url)
    self.members = self.githubfetch(self.endpoint + '/collaborators')
    self.get_information(self.contributors, 'login')
    self.get_information(self.members, 'login')
    
  #collaborators
  def githubfetch(self, endpoint):
    """
      Sends a get request to a github endpoint
    """
    headers = {
      "Authorization" : "token " + self.token
    }
    print(headers)
    response = requests.get(endpoint, headers=headers)
    text_object = json.loads(response.text)
    return text_object

  def get_information(self, members, key):
    """
      Prints out the information from an array object.
    """
    for member in members:
      #Could Write to File Here or save to DB?
      print(member[key])
  

if __name__ == '__main__':
  GitHubFetcher()