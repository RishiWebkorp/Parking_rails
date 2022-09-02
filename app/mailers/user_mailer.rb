class UserMailer < ApplicationMailer
    def check
        @slot = params[:slot]
        @car_no = params[:car_no]
        @intime = params[:intime]
        @name = params[:name]
        @status = params[:status]
        mail(to: "rishi@webkorps.com",subject: "About the intime of slot")
    end

    def outtime
        @outtime = params[:outtime]
        @name = params[:name]
        @status = params[:status]
        @price = params[:Price]
        mail(to: "rishi@webkorps.com",subject: "About the Outime of slot")
    end
end
