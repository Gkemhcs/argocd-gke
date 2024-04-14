from flask import Flask ,render_template,request,url_for,redirect
import requests,os

server=Flask(__name__)

API_KEY= os.getenv("QUOTES_API_KEY").strip()

url=os.getenv("QUOTES_API_URL").strip()

def get_compute_info():
   cluster_name=requests.get("http://metadata.google.internal/computeMetadata/v1/instance/attributes/cluster-name",headers={"Metadata-Flavor":"Google"}).text
   cluster_location=requests.get("http://metadata.google.internal/computeMetadata/v1/instance/attributes/cluster-location",headers={"Metadata-Flavor":"Google"}).text
   pod_name=os.getenv("HOSTNAME") or "localhost"
   return {"cluster_name":cluster_name,"cluster_location":cluster_location,"pod_name":pod_name}
def get_quote(category): 
          response=requests.get(url,headers={"X-Api-Key":API_KEY},params={"category":category})
          
          return response.json()



@server.route("/")
def home():
       
       return render_template("home.html",server_info=get_compute_info())

@server.route("/get-quote")
def generate_quote():
     response=get_quote(request.args.get("category"))
     print(response[0])
     return render_template("home.html",response=response[0],server_info=get_compute_info())
     
         

if(__name__=="__main__"):
          server.run(port=8080,host="0.0.0.0")


