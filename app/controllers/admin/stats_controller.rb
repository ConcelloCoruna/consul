class Admin::StatsController < Admin::BaseController

  def show
    @event_types = Ahoy::Event.group(:name).count

    @visits = Visit.count
    @debates = Debate.with_hidden.count
    @proposals = Proposal.with_hidden.count
    @comments = Comment.with_hidden.count

    @debate_votes = Vote.where(votable_type: 'Debate').count
    @proposal_votes = Vote.where(votable_type: 'Proposal').count
    @comment_votes = Vote.where(votable_type: 'Comment').count
    @votes = Vote.count

    @user_level_two = User.with_hidden.level_two_verified.count
    @user_level_three = User.with_hidden.level_three_verified.count
    @verified_users = User.with_hidden.level_two_or_three_verified.count
    @unverified_users = User.with_hidden.unverified.count
    @users = User.with_hidden.count
    @user_ids_who_voted_proposals =
     ActsAsVotable::Vote.where(votable_type: 'Proposal').pluck(:voter_id).uniq.count
    @user_ids_who_didnt_vote_proposals = @verified_users - @user_ids_who_voted_proposals
    @spending_proposals = SpendingProposal.count

  end
end
