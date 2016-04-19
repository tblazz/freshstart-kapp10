require 'csv'

class ResultController < ApplicationController

  protect_from_forgery with: :exception

  def new
  end

  def create
    #si on a un fichier
    if params[:file]
      #on récupère le fichier uploadé
      file = params[:file].read
      filename = params[:file].original_filename
      #on vérifie l'extension du fichier
      #TODO

      #on enregistre le fichier uploadé dans le répertoire public
      path = File.join Rails.root, 'public', filename
      if path
        File.open(path, 'wb') { |f| f.write file }
        #on parcours le fichier CSV
        CSV.foreach(path, :headers => true, :col_sep => ";") do |row|
          ProcessResultJob.perform_later(row.to_hash)
        end
      end

      File.delete path
    end
  end

end
