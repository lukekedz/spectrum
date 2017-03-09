<table>
	<tr>
		<th>Rank</th>
		<th>Team</th>
		<% @categories.each_with_index do |rh, index| %>
			<th><%= rh %></th>
		<% end %>
	</tr>

</table>


<h5><%= @team.abbr %>: <%= @team.name %></h5>

<% @stats.each do |day| %>
    <p><%= day.created_at.to_s[0..9] %> => <%= day.g %></p>
<% end %>
